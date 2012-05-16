# -*- coding: utf-8 -*-
ActiveAdmin.register Organization do
  menu :label => "Организации"

  filter :title

  form partial: 'form'
end
