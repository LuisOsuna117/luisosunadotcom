import profile from '../assets/profile.jpeg';
import Button from './Button';
import { FaLinkedin, FaFilePdf } from "react-icons/fa";

function Hero() {
    return (
        <div className="h-lvh bg-amazon flex flex-col justify-center items-center text-white">
            <img src={profile} className="w-40 rounded-full" alt="" />
            <h1 className='font-sans text-4xl mt-4'>Luis Osuna</h1>
            <h3 className='font-sans text-xl mt-1 text-center'>DevOps Engineer | Cloud Solutions Architect</h3>
            <div className='flex flex-col sm:flex-row'>
                <Button icon={FaLinkedin} color="azure" title="Get in touch" to="https://www.linkedin.com/in/luisosuna117" />
                <Button icon={FaFilePdf} color="amber" title="Download CV" to="/downloads/resume.pdf" />
            </div>

        </div>
    );
}

export default Hero;