require 'spec_helper'

describe "Magazine App" do
  let(:article_title) { "Hello World" }
  let(:article_content) { "This is my first article!!!" }

  before do
    @article1 = Article.create(:title => article_title, :content => article_content)
    @article2 = Article.create(:title => "second article", :content => "I'm a really good writer")
  end

  describe "Create Action" do

    it "creates a new article" do
      visit '/articles/new'

      fill_in :title, :with => "my favorite article"
      fill_in :content, :with => "content!!!!"

      page.find(:css, "[type=submit]").click

      expect(Article.all.count).to eq(3)
      expect(Article.last.title).to eq("my favorite article")
    end

    it "redirects to '/articles/:id'" do
      visit '/articles/new'

      fill_in :title, :with => "an article"
      fill_in :content, :with => "content content content content content"

      page.find(:css, "[type=submit]").click

      expect(page.current_path).to eq("/articles/#{Article.last.id}")
      expect(page.body).to include("content content content content content")
    end

  end

  describe "Read Action " do
    describe 'index action' do
      it 'responds with a 200 status code' do
        get "/articles"
        expect(last_response.status).to eq(200)
      end

      it "displays all the articles" do
        get "/articles"
        expect(last_response.body).to include(article_title)
        expect(last_response.body).to include(@article2.title)
      end
    end

    describe 'show action' do
      it 'show page responds with a 200 status code' do
        get "/articles/#{@article1.id}"
        expect(last_response.status).to eq(200)
      end

      it "show page displays the article's title" do
        get "/articles/#{@article1.id}"
        expect(last_response.body).to include(article_title)
      end

      it "show page displays the article's content" do
        get "/articles/#{@article1.id}"
        expect(last_response.body).to include(article_content)
      end
    end


  end


  describe "update action" do


    it 'responds with a 200 status code' do
      get "/articles/#{@article2.id}/edit"
      expect(last_response.status).to eq(200)
    end

    it 'displays the existing object in the edit form' do
      visit "/articles/#{@article2.id}/edit"
      expect(page.body).to include("#{@article2.title}")
      expect(page.body).to include("#{@article2.content}")

    end

    it "saves edits to an article" do
      visit "/articles/#{@article2.id}/edit"
      fill_in :title, :with => "Second Article!!"
      fill_in :content, :with => "this is the best article ever written"

      page.find(:css, "[type=submit]").click
      expect(Article.all.count).to eq(2)
      expect(Article.last.title).to eq("Second Article!!")
    end

    it "redirects to '/articles/:id'" do
      visit "/articles/#{@article2.id}/edit"
      fill_in :content, :with => "this is even better than the last"

      page.find(:css, "[type=submit]").click
      expect(page.current_path).to eq("/articles/#{@article2.id}")
      expect(page.body).to include("this is even better than the last")
    end

    it "submits the form via a patch request" do
      visit "/articles/#{@article2.id}/edit"
      expect(find("[name=_method]", :visible => false).value).to match(/patch/i)
    end

  end

  describe "delete action" do

    it 'responds with a 200 status code' do
      get "/articles/#{@article2.id}"
      expect(last_response.status).to eq(200)
    end

    it "deletes an article from the database" do
      visit "/articles/#{@article2.id}"
      page.find(:css, "form [type=submit]").click
      expect(Article.all.count).to eq(1)
      expect(Article.last.title).to eq("Hello World")
    end

    it "submits the form via a delete request" do
      visit "/articles/#{@article2.id}"
      expect(find("[name=_method]", :visible => false).value).to match(/delete/i)
    end

  end






end
