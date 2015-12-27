module CustomHelpers
    def mals_multiple product
        partial "partials/mals_multiple", locals: { product: product }
    end
    def current_page_data product
        data.public_send(current_page.path.split('.')[0]).public_send(product)
    end
end
