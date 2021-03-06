class TrackerAPI

  #state that class will store
  def initialize
    @conn = Faraday.new(:url => 'https://www.pivotaltracker.com')
  end
  #behavior for class. pass in token as an arguement
  def projects(token)
    return [ ] if token.nil? #precondition
    response = @conn.get do |req|
      req.url "/services/v5/projects"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = token
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def project(project_id, token)
    return [ ] if token.nil? #precondition
    response = @conn.get do |req|
      req.url "/services/v5/projects/#{project_id}"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = token
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def stories(tracker_id, token)
    return [ ] if token.nil?

    response = @conn.get do |req|
      req.url "/services/v5/projects/#{tracker_id}/stories?limit=500"
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-TrackerToken'] = token
    end
    JSON.parse(response.body, symbolize_names: true)
  end

end
