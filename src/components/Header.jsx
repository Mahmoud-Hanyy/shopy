import React, { useContext } from "react";
import { Link } from "react-router-dom";
import { useSelector } from "react-redux";
import { LanguageContext } from "../components/Language";
import { useTranslation } from "react-i18next";

const Header = () => {
  const totalItems = useSelector((state) =>
    state.cart.cartItems.reduce((sum, item) => sum + item.quantity, 0)
  );

  const { language, setLanguage } = useContext(LanguageContext);
  const { t, i18n } = useTranslation();

  const handleLanguageChange = (e) => {
    const newLang = e.target.value;
    setLanguage(newLang);
    i18n.changeLanguage(newLang);
  };

  return (
    <nav className="navbar navbar-expand-lg navbar-light bg-white border-bottom fixed-top shadow-sm">
      <div className="container">
        <Link className="navbar-brand text-dark fw-bold" to="/">
          {t("shopy")}
        </Link>
        <button
          className="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarNav"
        >
          <span className="navbar-toggler-icon"></span>
        </button>
        <div className="collapse navbar-collapse" id="navbarNav">
          <ul className="navbar-nav ms-auto align-items-center">
            <li className="nav-item me-3">
              <Link className="nav-link text-dark" to="/home">
                {t("home")}
              </Link>
            </li>
            <li className="nav-item me-3">
              <Link className="nav-link text-dark position-relative" to="/cart">
                <i className="bi bi-cart"></i> {t("cart")}
                {totalItems > 0 && (
                  <span className="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                    {totalItems}
                  </span>
                )}
              </Link>
            </li>
            <li className="nav-item">
              <select
                className="form-select form-select-sm"
                style={{ width: '80px' }}
                value={language}
                onChange={handleLanguageChange}
              >
                <option value="en">EN</option>
                <option value="ar">AR</option>
              </select>
            </li>
          </ul>
        </div>
      </div>
    </nav>
  );
};

export default Header;
