import React from 'react';
import { Link } from 'react-router-dom';

const Header = () => {
    return (
        <nav className="navbar navbar-expand-lg navbar-light bg-white border-bottom fixed-top shadow-sm">
            <div className="container">
                <Link className="navbar-brand text-dark fw-bold" to="/">Shopy</Link>

                <button className="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span className="navbar-toggler-icon"></span>
                </button>

                <div className="collapse navbar-collapse" id="navbarNav">
                    <ul className="navbar-nav ms-auto">
                        <li className="nav-item">
                            <Link className="nav-link text-dark" to="/">Register</Link>
                        </li>
                        <li className="nav-item">
                            <Link className="nav-link text-dark" to="/">Log In</Link>
                        </li>
                        <Link className="nav-link text-dark" to="/">
                            <i className="bi bi-cart"></i> Cart
                        </Link>
                    </ul>
                </div>
            </div>
        </nav>
    );
};

export default Header;
