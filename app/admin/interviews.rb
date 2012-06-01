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
    column :author
    default_actions
  end

  form html: { enctype: 'multipart/form-data' } do |f|
    f.inputs 'Основное' do
      f.input :title
      f.input :content, input_html: {size: 10}
      f.input :picture, as: :file, hint: f.template.image_tag(f.object.picture.url(:medium))
      f.input :interview_tag_list
    end
    f.buttons
  end

  show do
    attributes_table :title, :author, :content, :interview_tag_list

    panel 'Фотография' do
      image_tag(interview.picture.url)
    end
  end
end
