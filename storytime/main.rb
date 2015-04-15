     
require 'sinatra'
require 'active_record'
require 'pry'
require 'sinatra/contrib/all'

#database config
ActiveRecord::Base.establish_connection(
    :adapter => 'postgresql',
    :database => 'storytime'
)


class Story < ActiveRecord::Base
  validates :title, :presence => true
  has_many :chapters
end

class Chapter < ActiveRecord::Base
  belongs_to :story
end

before do 
  @chapters = Chapter.all
end



get '/' do
  erb :index
end


get '/createstory' do
  @story = Story.all
  @chapter = Chapter.all

  erb :createstory
end


post '/stories' do 
  story = Story.new
  story.title = params[:title]
  story.author = params[:author]
  story.genre = params[:genre]
  story.save

  chapter = Chapter.new
  chapter.chaptername = params[:chaptername]
  chapter.body = params[:body]
  chapter.story_id = story.id
  chapter.save
  redirect to '/stories/new'

end
 


get '/stories/new' do
  @stories = Story.all.reverse
  @chapters = Chapter.all.reverse
  erb :stories_new
end


delete '/stories/:id/delete' do 
  story = Story.find params[:id]
  story.delete
  redirect to '/'
end

get '/api/stories' do 
  content_type :json
  Story.all.to_json

end


post '/stories/view' do
  story = Story.find params[:id]
  # this probably isnt needed
end

get '/stories/view/:id' do
  @stories = Story.find params[:id]
  @chapters = Chapter.all
  erb :story_view
end


get '/stories/contribute/:id' do 
  @stories = Story.find (params[:id])
  story = Story.find (params[:id])
  story.save
  
  erb :stories_contribute
end

post '/stories/contribute' do 

  @stories = Story.all

  chapter = Chapter.new
  chapter.chaptername = params[:chaptername]
  chapter.body = params[:body]
  chapter.story_id = params[:story_id]
  chapter.save

  binding.pry
  redirect to '/stories/new'
end










post '/api/stories' do 
story = Story.new 
story.title = params[:title]
story.author = params[:author]
story.genre = params[:genre]
story.save

chapter = Chapter.new
chapter.chaptername = params[:chaptername]
chapter.body = params[:body]
chapter.story_id= Story.id
chapter.save

content_type :json 
post.to_json

end
