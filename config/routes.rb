Dir['../models/*.rb'].each { |file| require file }
I18n.load_path += Dir[File.join(File.dirname(__FILE__), '../locales', '*.yml').to_s]
CarrierWave.configure do |config|
    config.root = File.join(File.dirname(__FILE__), "../public")
end

helpers do
  def l(*args)
    I18n.l(*args)
  end
end

get '/' do
  @articles = Article.all
  haml :"/articles/index"
end

get '/articles' do
  @articles = Article.all
  haml :"/articles/index"
end

get '/article/:id' do
  @article = Article.find(params[:id])
  haml :"/articles/show"
end

get '/articles/new' do
  @article = Article.new
  haml :"/articles/new"
end

post '/articles' do
  @article = Article.new(params[:article])
  if @article.save
    redirect '/'
  else
    redirect '/articles/new'
  end
end

get '/article/:id/edit' do
  @article = Article.find(params[:id])
  haml :"/articles/edit"
end

patch '/article/:id' do
  @article = Article.find(params[:id])
  if @article.update(params[:article])
    redirect '/'
  else
    redirect "/articles/#{@article.id}"
  end
end

delete '/article/:id' do
  Article.find(params[:id]).destroy
  redirect '/'
end

post '/comments' do
  @comment = Comment.new(params[:comment])
  if @comment.save
    redirect "/article/#{@comment.article.id}"
  else
    redirect "/article/#{@comment.article.id}"
  end
end

delete '/comment/:id' do
  Comment.find(params[:id]).destroy
  redirect '/'
end
