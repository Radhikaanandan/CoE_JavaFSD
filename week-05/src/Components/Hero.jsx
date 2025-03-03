import React from "react";
import hero_img from '../assets/hero.png';

const Hero = () => {
    return (
        <div>
            <div className="grid w-full place-items-center bg-gradient-to-r from-[#6f02b8] via-[#d238f8] to-[#d78dfa] py-10">
                <div className="text-center max-w-3xl">
                    <h1 className="text-5xl font-bold mt-10 text-white">
                        Step Into The Future <br /> With Our Unique & Stylish Collection
                    </h1>
                    <p className="text-lg mt-3 text-white">
                    Shoezy offers stylish, modern footwear with a seamless shopping experience, <br />featuring unique collections, secure checkout, and an intuitive user interface..
                    </p>
                    <div className="justify-center mt-6 flex gap-5">
                        <button className="px-10 py-4 bg-white text-[#6f02b8] font-semibold rounded-full hover:bg-[#6f02b8] hover:text-white transition-all duration-300">
                            View Collections
                        </button>
                        <button className="px-10 py-4 border border-gray-300 text-black font-semibold rounded-full hover:bg-[#6f02b8] hover:text-white transition-all duration-300">
                            Explore More
                        </button>
                    </div>
                    <img src={hero_img} alt="Hero Image" className="w-[740px] h-[400px] mt-10 place-self-center" />
                </div>
            </div>
        </div>
    );
};

export default Hero;

