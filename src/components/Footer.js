import { FaGithub } from "react-icons/fa";
function Footer() {
    return (
        <div className="bg-amazon h-40 flex flex-col p-4 2xl:p-0 justify-center items-center text-white">
            <div><a href="https://github.com/LuisOsuna117"><FaGithub className="text-white w-10 h-10 m-2 hover:text-cyan-400"/></a></div>
            <div className="text-center">This website was built using <a className="text-cyan-400" href="https://github.com/facebook/react">React</a> and <a className="text-cyan-400" href="https://tailwindcss.com">TailwindCSS</a>.</div>
        </div>
    );
}

export default Footer;