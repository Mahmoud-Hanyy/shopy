import React from 'react';
import { Link } from 'react-router-dom';
import { useSelector } from 'react-redux';

const Header = () => {
    const totalItems = useSelector(state =>
        state.cart.cartItems.reduce((sum, item) => sum + item.quantity, 0)
    );

    return (
        <nav className="navbar navbar-expand-lg navbar-light bg-white border-bottom fixed-top shadow-sm">
            <div className="container">
                <Link className="navbar-brand text-dark fw-bold" to="/">Products App</Link>
                <button className="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span className="navbar-toggler-icon"></span>
                </button>
                <div className="collapse navbar-collapse" id="navbarNav">
                    <ul className="navbar-nav ms-auto">
                        <li className="nav-item">
                            <Link className="nav-link text-dark" to="/">Home</Link>
                        </li>
                        <li className="nav-item">
                            <Link className="nav-link text-dark position-relative" to="/cart">
                                <i className="bi bi-cart"></i> Cart
                                {totalItems > 0 && (
                                    <span className="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                                        {totalItems}
                                    </span>
                                )}
                            </Link>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    );
};

export default Header;
