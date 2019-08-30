[![Build Status](https://jenkins.sonata-nfv.eu/buildStatus/icon?job=tng-api-gtw/master)](https://jenkins.sonata-nfv.eu/job/tng-api-gtw/master)[![Join the chat at https://gitter.im/sonata-nfv/Lobby](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/sonata-nfv/Lobby)

<p align="center"><img src="https://github.com/sonata-nfv/tng-api-gtw/wiki/images/sonata-5gtango-logo-500px.png" /></p>

# 5GTANGO API Gateway
This is the 5GTANGO API Gateway for the Verification&amp;Validation and Service Platforms (built on top of [SONATA](https://github.com/sonata-nfv)) repository.

Please see [details on the overall 5GTANGO architecture here](https://5gtango.eu/project-outcomes/deliverables/2-uncategorised/31-d2-2-architecture-design.html). 

## How does this work?

This component has the follwoing architecture:

<p align="center"><img src="https://github.com/sonata-nfv/tng-api-gtw/wiki/images/api_gtw.png" /></p>

All external requests enter the [security gateway](https://github.com/sonata-nfv/tng-api-gtw/tree/master/tng-sec-gtw), where they are redirected to the adequate port and to the [router](https://github.com/sonata-nfv/tng-api-gtw/tree/master/tng-router) component, where the request is delivered to the pre-defined component.

For further details on those components, please check their README files

* [Security Gateway README](https://github.com/sonata-nfv/tng-api-gtw/tree/master/tng-sec-gtw/README.md);
* [Router README](https://github.com/sonata-nfv/tng-api-gtw/tree/master/tng-router/README.md).

## Versioning

For the versions available, see the [link to releases on this repository](/releases).

## Licensing

For licensing issues, please check the [Licence](https://github.com/sonata-nfv/tng-api-gtw/blob/master/LICENSE) file.

#### Feedback-Channel

* Please use the GitHub issues to report bugs.
* You may use the mailing list [sonata-dev@lists.atosresearch.eu](mailto:sonata-dev@lists.atosresearch.eu)
