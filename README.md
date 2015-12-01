
## Sinatra ActiveRecord CRUD

1. 

## Instructions

We've had a lot of practice with the ActiveRecord CRUD actions, so now it's time to tie them to controller actions in a Sinatra application. In this lab, you'll be building a basic blog post app, using every CRUD action.

### Database

First, you'll need to create the `posts` table. A blog post should have a name and content.

Next, you'll need to set up the corresponding `Post` model. Make sure the class inherits from `ActiveRecord::Base`.

### Create

Now that we have the database and model set up, it's time to set up the ability to create a blog post.

We need to create an erb with a form that POSTs to a controller action that creates the post and saves it to the database.

### Read

The Read CRUD action corresponds to two different controller actions: show and index.

We need to create two controller actions: one to view an individual blog post, and one to view all the blog posts.

Create two controller actions, each with a corresponding view.

### Update

The Update CRUD action corresponds to the edit controller action. 

Create a form to update a specific blog post, and POSTs to a controller action that updates the information in the browser.

### Delete

The Delete CRUD action corresponds to the delete controller action. 


## Resources

* [Stack Exchange](http://www.stackexchange.com) - [Some Question on Stack Exchange](http://www.stackexchange.com/questions/123)

# Sinatra Ar Crud Lab