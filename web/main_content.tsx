import * as React from "react";
import * as BP from "@blueprintjs/core";
import { URL_LIST } from "./url_list";

interface State {
    /** The index of the URL in URL_LIST we wish to display. Rotates in a circle. */
    pos: number;
    /** Time ID, so you can cancel it and not create memory leaks. */
    timerId?: number | undefined;
}

interface Props {
}

const INTERVAL = 50000;

export class MainContent extends React.Component<Props, State> {
    constructor() {
        super();
        this.rotate = this.rotate.bind(this);
        this.state = {
            pos: 0,
        };
    }

    rotate() {
        let {pos} = this.state;
        this.setState({ pos: (pos == URL_LIST.length) ? 0 : (pos + 1) });
    }

    componentDidMount() {
        this.setState({ timerId: window.setInterval(this.rotate, INTERVAL) });
    }

    componentWillUnmount() {
        if (this.state.timerId) { window.clearInterval(this.state.timerId); }
    }

    render() {
        return <div>
            <h1 > Fox.Build</h1 >
            <h2>Technology, Entrepreneurship and Art in St. Charles</h2>
            <iframe src={URL_LIST[this.state.pos]}
                width={window.screen.width - 40}
                height={window.screen.height - 40} />
        </div >;
    }
}
