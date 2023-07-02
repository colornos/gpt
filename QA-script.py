from transformers import GPT2LMHeadModel, GPT2Tokenizer

def test_model(input_text, model_path='./fine_tuned_model', model_name='gpt2'):
    tokenizer = GPT2Tokenizer.from_pretrained(model_name)
    model = GPT2LMHeadModel.from_pretrained(model_path)

    # Encode input text
    input_text = tokenizer.encode(input_text, return_tensors='pt')

    # Generate a sequence of tokens
    output = model.generate(input_text, max_length=150, temperature=0.9, pad_token_id=tokenizer.eos_token_id)

    # Decode the output tokens
    output_text = tokenizer.decode(output[:, input_text.shape[-1]:][0], skip_special_tokens=True)

    return output_text

def main():
    while True:
        user_input = input("Please enter a question (or 'quit' to exit): ")

        if user_input.lower() == 'quit':
            break

        print(f"Answer: {test_model(user_input)}\n")

# Call the main function to start the question-answering loop
main()
