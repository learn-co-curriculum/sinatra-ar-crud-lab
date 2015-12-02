
## Sinatra ActiveRecord CRUD

1. Implement all four CRUD actions in a Sinatra application
2. Explain how each CRUD action corresponds to a controller action and POST request

## Instructions

We've had a lot of practice with the ActiveRecord CRUD actions, so now it's time to tie them to controller actions in a Sinatra application. In this lab, you'll be building a basic blog post app, using every CRUD action.

### Database

First, you'll need to create the `posts` table. A blog post should have a name and content.

Next, you'll need to set up the corresponding `Post` model. Make sure the class inherits from `ActiveRecord::Base`.

### Create

Now that we have the database and model set up, it's time to set up the ability to create a blog post.

We need to create an erb file with a form that POSTs to a controller action. The controller action should use the Create CRUD action to create the blog post and save it to the database.

### Read

The Read CRUD action corresponds to two different controller actions: show and index.

We need to create two controller actions: one to view an individual blog post, and one to view all the blog posts.

Create two controller actions, each with a corresponding view.

### Update

The Update CRUD action corresponds to the edit controller action. 

Create a form to update a specific blog post, and POSTs to a controller action that updates the information in the browser.

### Delete

The Delete CRUD action corresponds to the delete controller action. You'll need to create a GET request that loads a form to delete a single post. You'll need to use a dynamic route, which contains the blog post's ID. The form doesn't need any input fields, just a submit button. The form should POST to a delete controller action, which will delete the post from the database.