ActiveAdmin.register AdminUser do
  
    
  menu :if => proc{ can?(:manage, AdminUser) }     
  controller.authorize_resource 

  
  index do
    column :email
    column :role
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end
  
  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :role, :collection => AdminUser::ROLES
    end
    f.buttons
  end
  
  show do
    attributes_table do
        row :id
        row :email
        row :role
        row :encrypted_password
        row :reset_password_token
        row :reset_password_sent_at
        row :remember_created_at
        row :sign_in_count
        row :current_sign_in_at
        row :last_sign_in_at
        row :current_sign_in_ip
        row :last_sign_in_ip
        row :created_at
        row :updated_at
      end
  end
end
