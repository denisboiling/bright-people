# -*- coding: utf-8 -*-
ActiveAdmin.register Stage do
  menu label: 'Сцены', :parent => "Фестиваль"

  filter :title

  index do
    id_column
    column :year
    column :category
    column :content
    column "Большая картинка" do |cr|
        link_to image_tag(cr.large_pic.url, alt: cr.category), admin_stage_path(cr)
    end
    column "Маленькая картинка" do |cr|
        link_to image_tag(cr.small_pic.url, alt: cr.category), admin_stage_path(cr)
    end
    default_actions
  end

  form html: { enctype: 'multipart/form-data' } do |f|
    f.inputs 'Основное' do
      f.input :year, as: :select, collection: (2012..Time.now.year + 5).to_a, include_blank: false
      f.input :content
      f.input :category, as: :select, collection: all_stages, include_blank: false
      f.input :small_pic, as: :file
      f.input :large_pic, as: :file
    end
    f.buttons
  end

  show do
    attributes_table :category, :content

    panel 'Маленькая картинка' do
      image_tag(stage.small_pic.url)
    end

    panel 'Большая картинка' do
      image_tag(stage.large_pic.url)
    end

  end
end
