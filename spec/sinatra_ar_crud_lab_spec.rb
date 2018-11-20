require 'spec_helper'

describe "Magazine App" do
  let(:article_name) { "Hello World" }
  let(:article_content) { "This is my first article!!!" }

  before do
    @article1 = Article.create(:name => article_name, :content => article_content)
    @article2 = Article.create(:name => "second article", :content => "i'm a really good writer")
  end

  describe "Create Action" do

    it "creates a new article" do
      visit '/articles/new'

      fill_in :name, :with => "my favorite article"
      fill_in :content, :with => "content!!!!"

      click_button 'submit'

      expect(Article.all.count).to eq(3)
      expect(Article.last.name).to eq("my favorite article")
    end

    it "redirects to '/articles'" do
      visit '/articles/new'

      fill_in :name, :with => "an article"
      fill_in :content, :with => "content content content content content"

      click_button 'submit'

      expect(page.current_path).to eq('/articles')
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
        expect(last_response.body).to include(article_name)
        expect(last_response.body).to include(@article2.name)
      end
    end

    describe 'show action' do
      it 'show page responds with a 200 status code' do
        get "/articles/#{@article1.id}"
        expect(last_response.status).to eq(200)
      end

      it "show page displays the article's name" do
        get "/articles/#{@article1.id}"
        expect(last_response.body).to include(article_name)
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
      expect(page.body).to include("#{@article2.name}")
      expect(page.body).to include("#{@article2.content}")

    end

    it "saves edits to an article" do
      visit "/articles/#{@article2.id}/edit"
      fill_in :name, :with => "Second Article!!"
      fill_in :content, :with => "this is the best article ever written"

      click_button 'submit'
      expect(Article.all.count).to eq(2)
      expect(Article.last.name).to eq("Second Article!!")
    end

    it "redirects to '/articles/:id'" do
      visit "/articles/#{@article2.id}/edit"
      fill_in :content, :with => "this is even better than the last"

      click_button 'submit'
      expect(page.current_path).to eq("/articles/#{@article2.id}")
      expect(page.body).to include("this is even better than the last")
    end

    it "submits the form via a patch request" do
      visit "/articles/#{@article2.id}/edit"
      expect(find("#hidden", :visible => false).value).to eq("patch")
    end

  end

  describe "delete action" do

    it 'responds with a 200 status code' do
      get "/articles/#{@article2.id}"
      expect(last_response.status).to eq(200)
    end

    it "deletes an article from the database" do
      visit "/articles/#{@article2.id}"
      click_button "delete"
      expect(Article.all.count).to eq(1)
      expect(Article.last.name).to eq("Hello World")
    end

    it "submits the form via a delete request" do
      visit "/articles/#{@article2.id}"
      expect(find("#hidden", :visible => false).value).to eq("delete")
    end

  end






end
