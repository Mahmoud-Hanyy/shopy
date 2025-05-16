import React from 'react';
import { useSelector, useDispatch } from 'react-redux';
import { increment, decrement, removeFromCart } from '../app/CartSlice';

const Cart = () => {
    const dispatch = useDispatch();
    const { cartItems } = useSelector(state => state.cart);

    if (cartItems.length === 0) {
        return <h3 className="mt-5 text-center">Your cart is empty</h3>;
    }

    return (
        <div className="mt-5">
            <h3 className="mb-4">Shopping Cart</h3>
            {cartItems.map(item => (
                <div key={item.id} className="d-flex justify-content-between align-items-center mb-3 border-bottom pb-2">
                    <div>
                        <h5>{item.title}</h5>
                        <p className="text-muted">${item.price}</p>
                        <div className="d-flex align-items-center">
                            <button className="btn btn-sm btn-outline-secondary me-2" onClick={() => dispatch(decrement(item.id))}>-</button>
                            <span>{item.quantity}</span>
                            <button className="btn btn-sm btn-outline-secondary ms-2" onClick={() => dispatch(increment(item.id))}>+</button>
                            <button className="btn btn-sm btn-outline-danger ms-3" onClick={() => dispatch(removeFromCart(item.id))}>Remove</button>
                        </div>
                    </div>
                    <img src={item.thumbnail} alt={item.title} style={{ width: '80px', height: '80px', objectFit: 'cover' }} />
                </div>
            ))}
        </div>
    );
};

export default Cart;
