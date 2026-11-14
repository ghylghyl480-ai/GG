import express from "express";
import { Mistral } from "@mistralai/mistralai";
import path from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

if (!process.env.MISTRAL_API_KEY) {
  console.error("Defina MISTRAL_API_KEY no ambiente antes de iniciar. Ex.: export MISTRAL_API_KEY=sua-chave");
  process.exit(1);
}

const client = new Mistral({ apiKey: process.env.MISTRAL_API_KEY });
const MODEL = "mistral-small-latest";

const app = express();
app.use(express.json());
app.use(express.static(path.join(__dirname, "public")));

app.post("/api/chat", async (req, res) => {
  const { messages } = req.body ?? {};
  if (!Array.isArray(messages) || messages.length === 0) {
    return res.status(400).json({ error: "Envie 'messages': [{ role, content }]." });
  }

  const safeMessages = messages
    .filter((m) => m && typeof m.content === "string" && m.content.trim())
    .map((m) => ({ role: m.role === "assistant" ? "assistant" : "user", content: m.content }))
    .slice(-20);

  res.setHeader("Content-Type", "text/event-stream; charset=utf-8");
  res.setHeader("Cache-Control", "no-cache");
  res.setHeader("Connection", "keep-alive");
  res.flushHeaders();

  try {
    const stream = await client.chat.stream({
      model: MODEL,
      messages: safeMessages,
    });
    for await (const event of stream) {
      const delta = event.data.choices?.[0]?.delta?.content;
      if (delta) {
        res.write(`data: ${JSON.stringify({ delta })}\n\n`);
      }
    }
    res.write("data: [DONE]\n\n");
  } catch (err) {
    console.error(err);
    res.write(`data: ${JSON.stringify({ error: "Falha ao chamar a API da Mistral." })}\n\n`);
  } finally {
    res.end();
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Chat Mistral rodando em http://localhost:${PORT}`);
});
