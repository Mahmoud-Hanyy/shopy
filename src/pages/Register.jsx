import { useState } from "react";
import { useNavigate } from "react-router-dom";

function Register() {
    const navigate = useNavigate();

    const [formData, setFormData] = useState({
        email: "",
        name: "",
        username: "",
        password: "",
        confirmPassword: "",
    });

    const [errors, setErrors] = useState({});

    const validate = () => {
        const newErrors = {};
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        const usernameRegex = /^\S+$/; // no spaces
        const passwordRegex =
            /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@%$#*])[A-Za-z\d@%$#*]{8,}$/;

        if (!formData.email || !emailRegex.test(formData.email)) {
            newErrors.email = "Valid email is required";
        }

        if (!formData.name) {
            newErrors.name = "Name is required";
        }

        if (!formData.username || !usernameRegex.test(formData.username)) {
            newErrors.username = "Username is required and must contain no spaces";
        }

        if (!formData.password || !passwordRegex.test(formData.password)) {
            newErrors.password =
                "Password must be 8+ chars, include upper, lower, digit, and symbol (@%$#*)";
        }

        if (!formData.confirmPassword || formData.confirmPassword !== formData.password) {
            newErrors.confirmPassword = "Passwords must match";
        }

        return newErrors;
    };

    const handleSubmit = (e) => {
        e.preventDefault();
        const validationErrors = validate();
        setErrors(validationErrors);

        if (Object.keys(validationErrors).length === 0) {
            alert(JSON.stringify(formData, null, 2));
            navigate("/home");
        }
    };

    return (
        <div className="container mt-4" style={{ maxWidth: "600px" }}>
            <h2>Register</h2>
            <form onSubmit={handleSubmit} noValidate>
                <div className="mb-3">
                    <label className="form-label">Email address</label>
                    <input
                        type="email"
                        className={`form-control ${errors.email && "is-invalid"}`}
                        value={formData.email}
                        onChange={(e) => setFormData({ ...formData, email: e.target.value })}
                    />
                    {errors.email && <div className="invalid-feedback">{errors.email}</div>}
                </div>
                <div className="mb-3">
                    <label className="form-label">Name</label>
                    <input
                        type="text"
                        className={`form-control ${errors.name && "is-invalid"}`}
                        value={formData.name}
                        onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                    />
                    {errors.name && <div className="invalid-feedback">{errors.name}</div>}
                </div>

                <div className="mb-3">
                    <label className="form-label">Username</label>
                    <input
                        type="text"
                        className={`form-control ${errors.username && "is-invalid"}`}
                        value={formData.username}
                        onChange={(e) => setFormData({ ...formData, username: e.target.value })}
                    />
                    {errors.username && <div className="invalid-feedback">{errors.username}</div>}
                </div>
                <div className="mb-3">
                    <label className="form-label">Password</label>
                    <input
                        type="password"
                        className={`form-control ${errors.password && "is-invalid"}`}
                        value={formData.password}
                        onChange={(e) => setFormData({ ...formData, password: e.target.value })}
                    />
                    {errors.password && <div className="invalid-feedback">{errors.password}</div>}
                </div>
                <div className="mb-3">
                    <label className="form-label">Confirm Password</label>
                    <input
                        type="password"
                        className={`form-control ${errors.confirmPassword && "is-invalid"}`}
                        value={formData.confirmPassword}
                        onChange={(e) => setFormData({ ...formData, confirmPassword: e.target.value })}
                    />
                    {errors.confirmPassword && (
                        <div className="invalid-feedback">{errors.confirmPassword}</div>
                    )}
                </div>

                <button type="submit" className="btn btn-dark w-100">
                    Register
                </button>
            </form>
        </div>
    );
}

export default Register;
