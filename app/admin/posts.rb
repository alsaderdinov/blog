ActiveAdmin.register Post do
  permit_params :user_id, :title, :body, :image

  show do
    default_main_content do
      row :image do |post|
        image_tag(post.image, size: '200x200') if post.image.attached?
      end
      panel 'Comments' do
        table_for post.comments do
          column :id
          column :body
          column :user
          column :created_at
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :user, collection: User.all.map { |user| [user.email, user.id] }
      f.input :title
      f.input :body
      f.input :image, as: :file
    end
    f.actions
  end
end
