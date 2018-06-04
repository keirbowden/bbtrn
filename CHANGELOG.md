# Changelog

## [v1.5](https://github.com/keirbowden/bbtrn/releases/tag/V1.5) (???)
[Full Changelog](https://github.com/keirbowden/bbtrn/compare/V1.4...V1.5)

**Implemented enhancements:**

- 

**Fixed bugs:**

- If a user misses answering a question, now generates an error message
- Handle scenario where a path doesn't have any topics

## [v1.4](https://github.com/keirbowden/bbtrn/releases/tag/V1.4) (2017-05-13)
[Full Changelog](https://github.com/keirbowden/bbtrn/compare/V1.3...V1.4)

**Implemented enhancements:**

- Added info modal with version and changes
- Toggle paths view between card and list
- Admin with the Training_Run_As permission set can run as a specified email address

**Fixed bugs:**

- 

## [v1.3](https://github.com/keirbowden/bbtrn/releases/tag/V1.3) (2017-05-06)
[Full Changelog](https://github.com/keirbowden/bbtrn/compare/V1.2...V1.3)

**Implemented enhancements:**

- Added filtering by topic

**Fixed bugs:**

- 

## [v1.2](https://github.com/keirbowden/bbtrn/releases/tag/V1.2) (2017-04-30)
[Full Changelog](https://github.com/keirbowden/bbtrn/compare/V1.1...V1.2)

**Implemented enhancements:**

- Improved formatting when the training SPA is embedded in a standard page (tested on the Chatter People page).
- Endpoints may be restricted based on the optional Endpoints__c custom field on the User sobject. This is not part of the codebase, but will be respected if present.

**Fixed bugs:**

- 

## [v1.1](https://github.com/keirbowden/bbtrn/releases/tag/V1.1) (2017-04-30)
[Full Changelog](https://github.com/keirbowden/bbtrn/compare/V1.0...V1.1)

**Implemented enhancements:**

- Some tweaks to styling to make it slightly less grey
- Added buttons to navigate between steps and paths.

**Fixed bugs:**

- A number of minor bug fixes.

## [v1.0](https://github.com/keirbowden/bbtrn/releases/tag/V1.0) (2017-03-31)

**Implemented enhancements:**

- Added versioning - the client now stores its version in code and sends this with each request to an endpoint. 
- If the endpoint doesn't support the version, it will throw an exception detailing the issue - either the client or the endpoint needs upgrading - that the client displays to the server.

**Fixed bugs:**
