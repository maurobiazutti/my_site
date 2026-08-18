module ApplicationHelper
  def nav_link_to(name, path)
    link_to name, path, class: "rounded-lg px-3 py-2 text-sm font-medium text-gray-700 transition-colors hover:bg-rose-50 hover:text-rose-700"
  end
end
