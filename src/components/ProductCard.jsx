import React from "react";
import { Link } from "react-router-dom";
import { useDispatch } from "react-redux";
import { addToCart } from "../app/CartSlice";

function ProductCard({ product }) {
  const dispatch = useDispatch();
  return (
    <div className="card h-100 mt-5">
      <img
        src={product.thumbnail}
        className="card-img-top"
        alt={product.title}
        style={{ height: "200px", objectFit: "cover" }}
      />
      <div className="card-body d-flex flex-column">
        <h5 className="card-title">{product.title}</h5>
        <p className="card-text text-truncate">{product.description}</p>
        <div className="mt-auto">
          <p className="fw-bold">${product.price}</p>
          <Link to={`/product/${product.id}`} className="btn btn-primary w-100 mb-3">
            View Details
          </Link>
          <button
            className="btn btn-success w-100"
            onClick={() => dispatch(addToCart(product))}
          >
            Add to Cart
          </button>
        </div>
      </div>
    </div>
  );
}

export default ProductCard;
