from transformers import GPT2Tokenizer, GPT2LMHeadModel, TextDataset, DataCollatorForLanguageModeling
from transformers import Trainer, TrainingArguments
from datasets import load_dataset

# Load a pre-trained GPT-2 tokenizer
tokenizer = GPT2Tokenizer.from_pretrained('gpt2')

# Load the OpenWebText2 dataset
dataset = load_dataset("openwebtext2")

# Preprocess the data
def tokenize_function(examples):
    return tokenizer(examples["text"], truncation=True, max_length=512)

tokenized_dataset = dataset.map(tokenize_function, batched=True)

# Create a torch.utils.data.Dataset object for training
dataset_train = tokenized_dataset['train']

# Load a pre-trained GPT-2 model
model = GPT2LMHeadModel.from_pretrained('gpt2')

# Define the training arguments
training_args = TrainingArguments(
    output_dir="./results", # The output directory
    overwrite_output_dir=True, # Overwrite the content of the output directory
    num_train_epochs=3, # The number of epochs
    per_device_train_batch_size=1, # Batch size for training
    save_steps=10_000, # After # steps model is saved
    save_total_limit=2, # Only last 2 models are saved. Older ones are deleted.
)

# Define a data collator
data_collator = DataCollatorForLanguageModeling(
    tokenizer=tokenizer, mlm=False,
)

# Initialize a Trainer instance
trainer = Trainer(
    model=model,
    args=training_args,
    data_collator=data_collator,
    train_dataset=dataset_train,
)

# Start training
trainer.train()
