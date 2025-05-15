import React, { useEffect, useState } from "react";
import axios from "axios";
import ProductCard from "../components/ProductCard";

function Home() {
    const [products, setProducts] = useState([]);

    useEffect(() => {
        axios
            .get("https://dummyjson.com/products")
            .then((res) => setProducts(res.data.products))
            .catch((err) => console.error(err));
    }, []);

    return (
        <div className="row">
            {products.map((product) => (
                <div className="col-md-4 mb-4" key={product.id}>
                    <ProductCard product={product} />
                </div>
            ))}
        </div>
    );
}

export default Home;
