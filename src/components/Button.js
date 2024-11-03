import PropTypes from 'prop-types';

function Button(props) {
    const { icon: Icon, color, to, title} = props;
    const colors = {
        amber: 'bg-amber',
        azure: 'bg-azure',
    };
    return (
        <a href={to} className={`${colors[color]} text-center flex flex-row rounded py-2 px-8 my-2 mx-1 font-bold justify-center items-center`}>
            <Icon className='mr-2' size={24} /> {title}
        </a>
    );
}

Button.propTypes = {
    icon: PropTypes.any.isRequired,
    title: PropTypes.string.isRequired,
    color: PropTypes.string.isRequired,
    to: PropTypes.string.isRequired,
};

export default Button;