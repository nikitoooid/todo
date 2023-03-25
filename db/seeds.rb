Task.delete_all
User.delete_all

users = User.create([
  { email:'admin@admin.com', password:'12345678', password_confirmation:'12345678'},
  { email:'johndoe@mail.com', password:'12345678', password_confirmation:'12345678'}
])

users.each do |user|
  task = user.tasks.new({title:"initial task for #{user.email}"})
  task.save
end
