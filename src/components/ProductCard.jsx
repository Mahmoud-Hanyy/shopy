import React from 'react';
import { Link } from 'react-router-dom';

function ProductCard({ product }) {
    return (
        <div className="card h-100">
            <img src={product.thumbnail} className="card-img-top" alt={product.title} style={{ height: '200px', objectFit: 'cover' }} />
            <div className="card-body d-flex flex-column">
                <h5 className="card-title">{product.title}</h5>
                <p className="card-text text-truncate">{product.description}</p>
                <div className="mt-auto">
                    <p className="fw-bold">${product.price}</p>
                    <Link to={`/product/${product.id}`} className="btn btn-primary w-100">View Details</Link>
                </div>
            </div>
        </div>
    );
}

export default ProductCard;
