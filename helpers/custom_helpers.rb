module CustomHelpers
    def mals_multiple product
        partial "partials/mals_multiple", locals: { product: $product }
    end
end
