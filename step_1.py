from transformers import GPT2LMHeadModel, GPT2Tokenizer, TextDataset, DataCollatorForLanguageModeling
from transformers import Trainer, TrainingArguments

def fine_tune_gpt(dataset_path, model_name='gpt2', output_dir='./results', epochs=1):
    tokenizer = GPT2Tokenizer.from_pretrained(model_name)
    model = GPT2LMHeadModel.from_pretrained(model_name)

    # Load the dataset
    def load_dataset(dataset_path):
        train_dataset = TextDataset(
            tokenizer=tokenizer,
            file_path=dataset_path,
            block_size=128)
        return train_dataset

    train_dataset = load_dataset(dataset_path)

    # Define data collator
    data_collator = DataCollatorForLanguageModeling(
        tokenizer=tokenizer, mlm=False,
    )

    # Initialize Trainer
    training_args = TrainingArguments(
        output_dir=output_dir,         
        num_train_epochs=epochs,              
        per_device_train_batch_size=4,  
        per_device_eval_batch_size=4,   
        warmup_steps=500,                
        weight_decay=0.01,               
        logging_dir='./logs',            
    )

    trainer = Trainer(
        model=model,                         
        args=training_args,                  
        data_collator=data_collator,         
        train_dataset=train_dataset,         
    )

    # Train and save the model
    trainer.train()
    model.save_pretrained(output_dir)

# Use the function
fine_tune_gpt('QA-TrainingSet.txt', model_name='gpt2', output_dir='./fine_tuned_model', epochs=2)
