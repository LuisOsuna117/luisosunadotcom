import profile from '../assets/profile.jpeg';
import Button from './Button';
import { FaLinkedin, FaFilePdf, FaAngleDown } from "react-icons/fa";
import { useState, useEffect } from 'react';

function Hero() {
    const [isBouncing, setIsBouncing] = useState(true);

    useEffect(() => {
        const handleScroll = () => {
          if (window.scrollY > 0) {
            setIsBouncing(false);  // Stop bouncing when scrolling
          }
        };
        window.addEventListener('scroll', handleScroll);

    return () => {
      window.removeEventListener('scroll', handleScroll);
    };
  }, []);
    return (
        <div className="h-lvh bg-amazon flex flex-col justify-center items-center text-white">
            <img src={profile} className="w-40 rounded-full" alt="" />
            <h1 className='font-sans text-4xl mt-4'>Luis Osuna</h1>
            <h3 className='font-sans text-xl mt-1 text-center'>DevOps Engineer | Cloud Solutions Architect</h3>
            <div className='flex flex-col sm:flex-row'>
                <Button icon={FaLinkedin} color="azure" title="Get in touch" to="https://www.linkedin.com/in/luisosuna117" />
                <Button icon={FaFilePdf} color="amber" title="Get my resume" to="/downloads/resume.pdf" />
            </div>
            <div className={`${isBouncing ? 'animate-bounce' : ''} font-sans flex flex-row font-light absolute bottom-0`}>
                <FaAngleDown className='mt-1 mx-2'/>Scroll to find out more<FaAngleDown className='mt-1 mx-2'/>
            </div>
        </div>
    );
}

export default Hero;