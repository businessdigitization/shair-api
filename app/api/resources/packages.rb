module Resources
  class Packages < Grape::API
    resources :packages do
      get do
        packages = Package.all
        packages = Kaminari.paginate_array(packages)

        present paginate(packages), with: Entities::Package
      end
    end
  end
end
