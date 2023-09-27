CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(320) UNIQUE NOT NULL,
    hashed_password TEXT NOT NULL
);

CREATE TABLE contacts (
    contact_id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(user_id) NOT NULL,  
    contact_number VARCHAR(8) UNIQUE NOT NULL
);

CREATE TABLE bills (
    bill_id SERIAL PRIMARY KEY,
    bill_name VARCHAR(255) NOT NULL ,
    bill_total DECIMAL(10, 2) NOT NULL CHECK (bill_total >= 0), 
    Remarks TEXT,  
    payer_user_id INTEGER REFERENCES users(user_id) NULL,  
    payer_contact_id INTEGER REFERENCES contacts(contact_id) NULL,  
    tax_type_id INTEGER REFERENCES tax_types(tax_type_id) NOT NULL
);

CREATE TABLE bill_shares (
    bill_share_id SERIAL PRIMARY KEY,
    bill_id INTEGER REFERENCES bills(bill_id) NOT NULL,
    user_id INTEGER REFERENCES users(user_id) NULL,  
    contact_id INTEGER REFERENCES contacts(contact_id) NULL,  
    CHECK ((user_id IS NOT NULL) OR (contact_id IS NOT NULL))  
);


CREATE TABLE discounts (
    discount_id SERIAL PRIMARY KEY,
    bill_id INTEGER REFERENCES bills(bill_id) NOT NULL,  
    sequence_id INTEGER REFERENCES discount_sequences(sequence_id) NOT NULL,  
    amount DECIMAL(10, 2) NOT NULL CHECK (amount > 0), 
    isPercentage BOOLEAN NOT NULL      
);

CREATE TABLE discount_sequences (
    sequence_id SERIAL PRIMARY KEY,
    discount_order VARCHAR(50) NOT NULL 
);

CREATE TABLE tax_types (
    tax_type_id SERIAL PRIMARY KEY,
    tax_type VARCHAR(255) NOT NULL 
);

CREATE TABLE bill_items (
    item_id SERIAL PRIMARY KEY,
    bill_id INTEGER REFERENCES bills(bill_id) NOT NULL,  
    item_name VARCHAR(255) NOT NULL,  
    price DECIMAL(10, 2) NOT NULL CHECK (price > 0),  
    discount_excluded BOOLEAN NOT NULL 
);

CREATE TABLE item_share (
    item_share_id SERIAL PRIMARY KEY,
    item_id INTEGER REFERENCES bill_items(item_id) NOT NULL,  
    bill_id INTEGER REFERENCES bills(bill_id) NOT NULL,
    sharer_user_id INTEGER REFERENCES users(user_id) NULL,  
    sharer_contact_id INTEGER REFERENCES contact(contact_id) NULL, 
    item_amount_due DECIMAL(10, 2) NOT NULL CHECK (item_amount_due > 0),
    CHECK ((sharer_user_id IS NOT NULL) OR (sharer_contact_id IS NOT NULL))  -- Ensuring at least one is NOT NULL
);

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    bill_id INTEGER REFERENCES bills(bill_id) NOT NULL,
    payer_user_id INTEGER REFERENCES users(user_id) NULL,  -
    payer_contact_id INTEGER REFERENCES contacts(contact_id) NULL, 
    total_amount_due DECIMAL(10, 2) NOT NULL CHECK (total_amount_due > 0),
    is_paid BOOLEAN NOT NULL,
    CHECK ((payer_user_id IS NOT NULL) OR (payer_contact_id IS NOT NULL)) 
);
