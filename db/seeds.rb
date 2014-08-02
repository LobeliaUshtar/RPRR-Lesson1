User.create!([
  {
    username: "gabby",
    password: "gabby",
    password_confirmation: "gabby",
    role: "admin",
    time_zone: "Eastern Time (US & Canada)"
  },
  {
    username: "tester",
    password: "tester",
    password_confirmation: "tester",
    time_zone: "Pacific Time (US & Canada)"
  }
])

Category.create!([
  {
    name: "Ruby on Rails"
  },
  {
    name: "HTML"
  },
  {
    name: "CSS"
  }
])

user = User.find_by(username: "gabby")
user.posts.create!(title: "Coding on the Ruby Express", url: "http://codingontherubyexpress.tumblr.com", description: "A blog about what Becky is doing with her Ruby on Rails courses and things she is finding along the way.")