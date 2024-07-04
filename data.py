import csv
import random
from faker import Faker

# Initialize Faker
fake = Faker()

# Number of rows in the dataset
num_customers = 1000
num_purchases = 2000  # Assume each customer makes 2 purchases on average

# Define the fields for the customers dataset
customer_fields = ['id', 'name', 'email', 'phone_number', 'address', 'city', 'state', 'zip_code', 'date_of_birth']

# Define the fields for the purchases dataset
purchase_fields = ['purchase_id', 'customer_id', 'product_name', 'purchase_date', 'price']

# Generate product names and prices
products = [
    ('Laptop', 1000), ('Smartphone', 500), ('Headphones', 50),
    ('Monitor', 200), ('Keyboard', 30), ('Mouse', 20),
    ('Printer', 150), ('Tablet', 300), ('Camera', 400)
]

# Open CSV files to write the data
with open('customers.csv', mode='w', newline='') as customer_file, open('purchases.csv', mode='w', newline='') as purchase_file:
    customer_writer = csv.writer(customer_file)
    purchase_writer = csv.writer(purchase_file)
    
    # Write the headers
    customer_writer.writerow(customer_fields)
    purchase_writer.writerow(purchase_fields)
    
    # Write the customer data
    for i in range(1, num_customers + 1):
        customer_writer.writerow([
            i,
            fake.name(),
            fake.email(),
            fake.phone_number(),
            fake.street_address(),
            fake.city(),
            fake.state(),
            fake.zipcode(),
            fake.date_of_birth()
        ])
    
    # Write the purchase data
    for j in range(1, num_purchases + 1):
        customer_id = random.randint(1, num_customers)
        product = random.choice(products)
        purchase_writer.writerow([
            j,
            customer_id,
            product[0],
            fake.date_this_year(),
            product[1]
        ])

print("Datasets created successfully!")
