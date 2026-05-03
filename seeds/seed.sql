INSERT IGNORE INTO users (id, name, email, phones)
VALUES
    (1, 'John Doe', 'john@mail.com', '09171234567'),
    (2, 'Jane Smith', 'jane@mail.com', '09177654321');

INSERT IGNORE INTO posts (id, user_id, title)
VALUES
    (1, 1, 'Hello World'),
    (2, 2, 'My Second Post'),
    (3, 2, 'here');
