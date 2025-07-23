# User Posts Project

## Created by Andy Clemens

### Description

This project is a Ruby on Rails web application created for the Piada Jr Software Engineer programming assignment. It lets registered users create posts and displays those posts for everyone. Users can also view and delete their own posts. The webpage is designed to be responsive to both mobile and desktop platforms.

### Design

Users have fields for a first name, last name, unique email, and password. Posts have fields for a title and body. Additionally, a post belongs to a user, who can have many posts. This relationship is represented in the diagram below. Lastly, the post's created_at timestamp is used to display when the post was written.

![Database diagram showing Users and Posts](/app/assets/images/diagram.png "Database diagram")

The Devise gem was used to implement user registration and authentication.

## Installation

This application uses Ruby version 3.3.3.

To install and run the application from GitHub:

1. **Clone the repository:**

    ```bash
    git clone https://github.com/PotatOS03/piada-programming-assignment.git
    cd piada-programming-assignment
    ```

2. **Install dependencies:**

    ```bash
    bundle install
    ```

3. **Set up the database:**

    ```bash
    rails db:create
    rails db:migrate
    ```

4. (Optional) **Seed the database:**

    ```bash
    rails db:seed
    ```

5. **Start the Rails server:**

    ```bash
    rails server
    ```

6. Visit [`http://localhost:3000`](http://localhost:3000) in your browser to use the application.

## Testing

This application uses the default Minitest library from Rails. To run test cases, use the following command in the terminal:

```bash
rails test
```

Additionally, sample users and posts can be created by seeding the database, using the following command in the terminal:

```bash
rails db:seed
```
