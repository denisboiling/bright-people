# -*- coding: utf-8 -*-
ActiveAdmin.register User do
  scope :all, :default => true
  scope :experts
  scope :usuals

  filter :name

  index do
    id_column
    column "Фотография" do |user|
      link_to image_tag(user.avatar.url(:thumb), alt: user.name),
      admin_user_path(user)
    end
    column :name
    column :created_at
    default_actions
  end

  form html: { enctype: 'multipart/form-data' } do |f|
    f.inputs 'Основное' do
      f.input :email
      f.input :password
      f.input :role, as: :select, collection: Role.all
      f.input :name
      f.input :avatar, as: :file,
      hint: f.template.image_tag(f.object.avatar.url(:medium))
    end

    f.inputs 'Для эксперта' do
      f.input :description, input_html: {size: 10}
      f.input :about
    end
    f.buttons
  end

  show do
    attributes_table :name, :description, :about, :created_at, :updated_at

    panel 'Фотография' do
      image_tag(user.avatar.url)
    end
  end
end
