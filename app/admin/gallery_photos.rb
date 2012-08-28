# -*- coding: utf-8 -*-
ActiveAdmin.register GalleryPhoto do
  menu label: "Галерея", :parent => "Фото модуль"

  scope :all, :default => true
  scope :festival_photos
  scope :not_festival_photos

  filter :id
  filter :user, as: :select, collection: proc { User.photographers }
  filter :photo_file_name
  filter :photo_file_size
  filter :photo_fingerprint
  filter :shot_date

  index do
    id_column
    column "Фото" do |photo|
      link_to image_tag(photo.photo), admin_gallery_photo_path(photo)
    end
    column :photo_file_name
    column :shot_date
    column :photo_file_size do |photo|
      number_to_human_size(photo.photo_file_size)
    end
    column "Фотограф" do |photo|
      link_to photo.user.name, admin_user_path(photo.user)
    end
    column :views
    column :festival_category
    default_actions
  end

  form do |f|
    f.inputs "Основное" do
      f.input :user, as: :select, collection: User.photographers, include_blank: false
      f.input :photo, as: :file, hint: f.template.image_tag(f.object.photo.url)
      f.input :festival_category, as: :select, collection: FestivalCategory.all
    end
    f.buttons
  end

end
