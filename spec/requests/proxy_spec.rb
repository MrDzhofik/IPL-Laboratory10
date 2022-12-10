require 'rails_helper'

RSpec.describe "Proxy", type: :request do

  describe "GET /calc" do
    it "returns http success" do
      get "/"
      expect(response).to have_http_status(:success)
    end

    it "returns http success" do
      get "/proxy/view"
      expect(response).to have_http_status(:success)
    end

    it "returns different results" do
      get '/proxy/view.x?power=3&route=server&commit=FYosh'
      response_first = @response.body 
      get '/proxy/view.x?power=4&route=server&commit=Yosh'
      response_second = @response.body 
      expect(response_first).not_to be eq(response_second)
    end

    # при запросе через клиента файл browser_render подгружается и браузер имеет к нему доступ
    it "returns correct result" do
      get '/proxy/view.x?power=4&route=client&commit=Yosh'
      expect(body.include?('/browser_render.xslt')).to be true
    end

    # при запросе через сервер файл browser_render не подгружается 
    it "returns correct result" do
      get '/proxy/view.x?power=3&route=server&commit=Yosh'
      expect(body.include?('/browser_render.xslt')).to be false
    end
  end

end
