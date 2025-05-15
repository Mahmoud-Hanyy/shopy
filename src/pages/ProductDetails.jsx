import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { useParams, Link } from 'react-router-dom';

function ProductDetails() {
    const { id } = useParams();
    const [product, setProduct] = useState(null);

    useEffect(() => {
        axios.get(`https://dummyjson.com/products/${id}`)
            .then(res => setProduct(res.data))
            .catch(err => console.error(err));
    }, [id]);

    if (!product) return <p>Loading...</p>;

    return (
        <div>
            <Link to="/" className="btn btn-secondary mb-3">← Back</Link>
            <div className="card">
                <img src={product.thumbnail} alt={product.title} className="card-img-top" />
                <div className="card-body">
                    <h3>{product.title}</h3>
                    <p>{product.description}</p>
                    <h4>${product.price}</h4>
                    <p><strong>Category:</strong> {product.category}</p>
                    <p><strong>Rating:</strong> {product.rating}</p>
                </div>
            </div>
        </div>
    );
}

export default ProductDetails;
