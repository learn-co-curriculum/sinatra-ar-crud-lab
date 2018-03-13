## Sinatra ActiveRecord CRUD

1.  Implement all four CRUD actions in a Sinatra application.
2.  Understand how each CRUD action corresponds to a controller action and `POST`
    request.

## Instructions

We've had a lot of practice with the ActiveRecord CRUD actions, so now it's
time to tie them to controller actions in a Sinatra application. In this lab,
you'll be building a basic magazine app, using every CRUD action.

**Important:** In Sinatra, the order in which you define your routes in a
controller matters. Routes are matched in the order they are defined. So, if we
were to define the `get '/articles/:id'` route _before_ the `get '/articles/new'`
route, Sinatra would feed all requests for `/articles/new` to the `/articles/:id`
route and we should see an error telling us that your app is unable to find an
`Article` instance with an `id` of `"new"`. The takeaway is that you should define
your `/articles/new` route _before_ your `/articles/:id` route.

### Database

First, you'll need to create the `articles` table. An article should have a title
and content.

Next, set up the corresponding `Article` model. Make sure the class inherits from `ActiveRecord::Base`.

### Create

Now that we have the database and model set up, it's time to set up the ability
to create an article.

First, create a route in your controller, `get '/articles/new'`, that renders the
`new.erb` view.

We need to create an ERB file in the views directory, `new.erb`, with a form
that `POST`s to a controller action, `/articles`. The controller action should use
the Create CRUD action to create the article and save it to the database.
When the form on `new.erb` is submitted, the action, pointing to `/articles`,
will trigger a render of an `index.erb` file automatically. Before we can
fully test if our form is working, we need to create that `index.erb` file, as
our site will currently crash upon submission.

### Read

The Read CRUD action corresponds to two different controller actions: show and
index. The show action should render the ERB view `show.erb`, which shows an
individual article. The index action should render the ERB view `index.erb`, which
shows a list of _all_ of the articles.

Create the `get '/articles'` controller action. This action should use Active
Record to grab _all_ of the articles and store them in an instance variable,
`@articles`. Then, it should render the `index.erb` view. That view should use ERB
to iterate over `@articles` and render them on the page.

Create the `get '/articles/:id'` controller action. This action should use
Active Record to grab the article with the `id` that is in the `params` and set
it equal to `@article`. Then, it should render the `show.erb` view page. That
view should use ERB to render the `@article`'s title and content.

### Update

The Update CRUD action corresponds to the edit controller action and view.

Create a controller action, `get '/articles/:id/edit'`, that renders the view,
`edit.erb`. This view should contain a form to update a specific article and
`POST`s to a controller action, `patch '/articles/:id'`.

You'll need to make sure the edit form includes:

```html
<input id="hidden" type="hidden" name="_method" value="PATCH">
```

**Reminder:** Remember to add the `use Rack::MethodOverride` to your
`config.ru` file so that your app will know how to handle `PATCH`, `PUT`, and `DELETE`
requests!

### Delete

The Delete CRUD action corresponds to the delete controller action, `delete '/articles/:id'`. To initiate this action, we'll add a "delete" button to the
show page. This button will be in a form, but since the form isn't visible by
default, you should only be able to see the button (intriguing, I know). The
form will send a request to the delete controller action, where we will
identify the article to delete and delete it. Then, the action should redirect
to the index of all articles — we can't go back to the show page, since the
article has been deleted!

#### Making our Delete "Button"

In order to make a form that looks like a button, all we need to do is make a
form that has no input fields, only a "submit" button with a value of "delete".
So, give your form tag a method of `POST` and an action of `"/articles/:id'`.
Make sure to dynamically set the `:id` of the form action! You'll also need to
make sure the form includes the hidden input tag to change the request from
`POST` to `DELETE`.

<p class='util--hide'>View <a href='https://learn.co/lessons/sinatra-ar-crud-lab'>Sinatra ActiveRecord CRUD</a> on Learn.co and start learning to code for free.</p>
