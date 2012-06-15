# -*- coding: utf-8 -*-
ActiveAdmin.register ActivityComment do

  scope :all, :default => true
  scope :parents
  scope :childrens

  filter :name

  index do
    id_column
    column "Аватар" do |comment|
      link_to image_tag(comment.picture.url(:thumb), alt: comment.commentator),
      admin_comment_path(comment)
    end
    column :commentator
    column :content
    default_actions
  end

  form html: { enctype: 'multipart/form-data' } do |f|
    f.inputs 'Основное' do
      f.input :commentator
      f.input :content, input_html: {size: 10}
      f.input :picture, as: :file,
                        hint: f.template.image_tag(f.object.picture.url(:medium))
      f.input :activity, as: :select, collection: Activity.all
      f.input :is_parent, as: :boolean
    end
    f.buttons
  end

  show do
    attributes_table :commentator, :content, :is_parent,:created_at,
                     :updated_at, :activity

    panel 'Аватар' do
      image_tag(activity_comment.picture.url)
    end
  end
end
