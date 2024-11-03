function Divider(props) {
    const { title } = props
    return (
        <div className="flex flex-col justify-center items-center">
            <div className="py-3 text-xl font-semibold w-11/12 2xl:w-2/4 flex items-center text-sm text-black before:flex-1 before:border-t before:border-black/87 before:me-6 after:flex-1 after:border-t after:border-black/87 after:ms-6">{title}</div>
        </div>
    );
}

Divider.propTypes = {
    title: PropTypes.string.isRequired
};

export default Divider;