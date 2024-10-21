function Button(props) {
    const { icon: Icon, color, to } = props;
    const colors = {
        amber: 'bg-amber',
        azure: 'bg-azure',
    };
    return (
        <a href={to} className={`${colors[color]} text-center flex flex-row rounded py-2 px-8 m-2 font-bold justify-center items-center`}>
            <Icon className='mr-2' size={24}/> {props.title}
        </a>
    );
}

export default Button;