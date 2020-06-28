## Sinatra ActiveRecord CRUD

1. Implement all four CRUD actions in a Sinatra application.
2. Understand how each CRUD action corresponds to a controller action and `POST`
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
`Article` instance with an `id` of `"new"`. *The takeaway is that you should define
your `/articles/new` route _before_ your `/articles/:id` route.*

### Database

First, you'll need to create the `articles` table. An article should have a title (string)
and content (string).

Next, set up the corresponding `Article` model. Make sure the class inherits from `ActiveRecord::Base`.

If you've done everything correctly, you should be able to run `rake db:seed` to populate your database 
with a few sample articles.  Spend some time in `rake console` and make sure you know how to retrieve
all of the articles as well as get a single article using its id.  Create at least one article of 
your own from inside the console.

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

### Create

Now it's time to set up the ability to create an article.

First, create a route in your controller:  `get '/articles/new'`, that renders the
`new.erb` view.  This view will be a blank form that should submit a `POST` request
to `/articles`.  (Look up the method and action attributes for HTML forms if you
aren't sure how to do this).

Now you will need to tell your controller what to do when your form sends that
`POST` request, so create a route on your controller `post '/articles'` that creates a new
article from the `params` from the form, then redirects to that new article's show page.


### Update

The Update CRUD action corresponds to the edit controller action and view.

Create a controller action, `get '/articles/:id/edit'`, that renders the view
`edit.erb`. This view should contain a form to update a specific article--similar to the form
you made for a new article, but the fields should be pre-populated with the existing title and
content of the article. 

Define the controller action `patch '/articles/:id'`.  Although we want to send a `PATCH` request to `/articles/:id` to process the form, we have to be a little sneaky to trick HTML into letting us do something besides a `GET` or a `POST`.  
Your form will be configured to send a POST request in its method attribute, but then we'll have Sinatra override it: Inside the form itself, add a hidden field to specify a PATCH request like so:
```html
<input id="hidden" type="hidden" name="_method" value="PATCH">
```
 
**Reminder:** Add the `use Rack::MethodOverride` to your
`config.ru` file so that your app will know how to handle `PATCH`, `PUT`, and `DELETE`
requests!

(This is confusing and weird, and you should ask questions about it!)

### Delete

The Delete CRUD action corresponds to the delete controller action, `delete
'/articles/:id'`. To initiate this action, we'll add a "delete" button to the
*show page* (i.e., deleting won't have its own view). This button will be in a form, 
but the form won't have any other fields in it... just the single button. 
The form will send a request to the delete controller action, 
where we will identify the article to delete and delete it.  Then, the action should redirect
to the index of all articles — we can't go back to the show page, since the
article has been deleted!

#### Making our Delete "Button"

Give your form tag a method of `POST` and an action of `"/articles/:id'`.
Make sure to dynamically set the `:id` of the form action to reflect the id 
of the article you're editing! You'll also need to
make sure the form includes the hidden input tag to change the request from
`POST` to `DELETE`, similar to how we constructed the `PATCH` request above
