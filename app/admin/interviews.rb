# -*- coding: utf-8 -*-
ActiveAdmin.register Interview do
  menu label: 'Интервью'

  filter :title
  filter :author

  index do
    id_column
    column "Фотография" do |interview|
        link_to image_tag(interview.picture.url(:thumb), alt: interview.title), admin_interview_path(interview)
    end
    column :title
    column :is_enabled
    column :review_title
    column :review
    column :author
    default_actions
  end

  form :partial => "form"

  show do
    attributes_table :title, :author, :is_enabled, :review_title, :review, :content, :short_description, :interview_tag_list

    panel 'Фотография' do
      image_tag(interview.picture.url)
    end
  end
end
