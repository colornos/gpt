from transformers import GPTJForCausalLM, GPT2Tokenizer
 
tokenizer = GPT2Tokenizer.from_pretrained("EleutherAI/gpt-j-6B")
model = GPTJForCausalLM.from_pretrained("EleutherAI/gpt-j-6B")
 
prompt = "Once upon a time"
input_ids = tokenizer.encode(prompt, return_tensors="pt")
 
output = model.generate(input_ids, max_length=100, num_return_sequences=5)
 
for i in range(5):
    print(tokenizer.decode(output[i], skip_special_tokens=True))
