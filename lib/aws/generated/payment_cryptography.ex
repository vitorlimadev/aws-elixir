# WARNING: DO NOT EDIT, AUTO-GENERATED CODE!
# See https://github.com/aws-beam/aws-codegen for more details.

defmodule AWS.PaymentCryptography do
  @moduledoc """
  You use the Amazon Web Services Payment Cryptography Control Plane to manage the
  encryption keys you use for payment-related cryptographic operations.

  You can create, import, export, share, manage, and delete keys. You can also
  manage Identity and Access Management (IAM) policies for keys. For more
  information, see [Identity and access management](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/security-iam.html)
  in the *Amazon Web Services Payment Cryptography User Guide.*

  To use encryption keys for payment-related transaction processing and associated
  cryptographic operations, you use the [Amazon Web Services Payment Cryptography Data
  Plane](https://docs.aws.amazon.com/payment-cryptography/latest/DataAPIReference/Welcome.html).
  You can encrypt, decrypt, generate, verify, and translate payment-related
  cryptographic operations.

  All Amazon Web Services Payment Cryptography API calls must be signed and
  transmitted using Transport Layer Security (TLS). We recommend you always use
  the latest supported TLS version for logging API requests.

  Amazon Web Services Payment Cryptography supports CloudTrail, a service that
  logs Amazon Web Services API calls and related events for your Amazon Web
  Services account and delivers them to an Amazon S3 bucket that you specify. By
  using the information collected by CloudTrail, you can determine what requests
  were made to Amazon Web Services Payment Cryptography, who made the request,
  when it was made, and so on. If you don't conﬁgure a trail, you can still view
  the most recent events in the CloudTrail console. For more information, see the
  [CloudTrail User Guide](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/).
  """

  alias AWS.Client
  alias AWS.Request

  def metadata do
    %{
      abbreviation: nil,
      api_version: "2021-09-14",
      content_type: "application/x-amz-json-1.0",
      credential_scope: nil,
      endpoint_prefix: "controlplane.payment-cryptography",
      global?: false,
      protocol: "json",
      service_id: "Payment Cryptography",
      signature_version: "v4",
      signing_name: "payment-cryptography",
      target_prefix: "PaymentCryptographyControlPlane"
    }
  end

  @doc """
  Creates an *alias*, or a friendly name, for an Amazon Web Services Payment
  Cryptography key.

  You can use an alias to identify a key in the console and when you call
  cryptographic operations such as
  [EncryptData](https://docs.aws.amazon.com/payment-cryptography/latest/DataAPIReference/API_EncryptData.html) or
  [DecryptData](https://docs.aws.amazon.com/payment-cryptography/latest/DataAPIReference/API_DecryptData.html).

  You can associate the alias with any key in the same Amazon Web Services Region.
  Each alias is associated with only one key at a time, but a key can have
  multiple aliases. You can't create an alias without a key. The alias must be
  unique in the account and Amazon Web Services Region, but you can create another
  alias with the same name in a different Amazon Web Services Region.

  To change the key that's associated with the alias, call `UpdateAlias`. To
  delete the alias, call `DeleteAlias`. These operations don't affect the
  underlying key. To get the alias that you created, call `ListAliases`.

  **Cross-account use**: This operation can't be used across different Amazon Web
  Services accounts.

  ## Related operations:

    * `DeleteAlias`

    * `GetAlias`

    * `ListAliases`

    * `UpdateAlias`
  """
  def create_alias(%Client{} = client, input, options \\ []) do
    meta = metadata()

    Request.request_post(client, meta, "CreateAlias", input, options)
  end

  @doc """
  Creates an Amazon Web Services Payment Cryptography key, a logical
  representation of a cryptographic key, that is unique in your account and Amazon
  Web Services Region.

  You use keys for cryptographic functions such as encryption and decryption.

  In addition to the key material used in cryptographic operations, an Amazon Web
  Services Payment Cryptography key includes metadata such as the key ARN, key
  usage, key origin, creation date, description, and key state.

  When you create a key, you specify both immutable and mutable data about the
  key. The immutable data contains key attributes that defines the scope and
  cryptographic operations that you can perform using the key, for example key
  class (example: `SYMMETRIC_KEY`), key algorithm (example: `TDES_2KEY`), key
  usage (example: `TR31_P0_PIN_ENCRYPTION_KEY`) and key modes of use (example:
  `Encrypt`). For information about valid combinations of key attributes, see
  [Understanding key attributes](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-validattributes.html)
  in the *Amazon Web Services Payment Cryptography User Guide*. The mutable data
  contained within a key includes usage timestamp and key deletion timestamp and
  can be modified after creation.

  Amazon Web Services Payment Cryptography binds key attributes to keys using key
  blocks when you store or export them. Amazon Web Services Payment Cryptography
  stores the key contents wrapped and never stores or transmits them in the clear.

  **Cross-account use**: This operation can't be used across different Amazon Web
  Services accounts.

  ## Related operations:

    * `DeleteKey`

    * `GetKey`

    * `ListKeys`
  """
  def create_key(%Client{} = client, input, options \\ []) do
    meta = metadata()

    Request.request_post(client, meta, "CreateKey", input, options)
  end

  @doc """
  Deletes the alias, but doesn't affect the underlying key.

  Each key can have multiple aliases. To get the aliases of all keys, use the
  `ListAliases` operation. To change the alias of a key, first use `DeleteAlias`
  to delete the current alias and then use `CreateAlias` to create a new alias. To
  associate an existing alias with a different key, call `UpdateAlias`.

  **Cross-account use:** This operation can't be used across different Amazon Web
  Services accounts.

  ## Related operations:

    * `CreateAlias`

    * `GetAlias`

    * `ListAliases`

    * `UpdateAlias`
  """
  def delete_alias(%Client{} = client, input, options \\ []) do
    meta = metadata()

    Request.request_post(client, meta, "DeleteAlias", input, options)
  end

  @doc """
  Deletes the key material and all metadata associated with Amazon Web Services
  Payment Cryptography key.

  Key deletion is irreversible. After a key is deleted, you can't perform
  cryptographic operations using the key. For example, you can't decrypt data that
  was encrypted by a deleted Amazon Web Services Payment Cryptography key, and the
  data may become unrecoverable. Because key deletion is destructive, Amazon Web
  Services Payment Cryptography has a safety mechanism to prevent accidental
  deletion of a key. When you call this operation, Amazon Web Services Payment
  Cryptography disables the specified key but doesn't delete it until after a
  waiting period. The default waiting period is 7 days. To set a different waiting
  period, set `DeleteKeyInDays`. During the waiting period, the `KeyState` is
  `DELETE_PENDING`. After the key is deleted, the `KeyState` is `DELETE_COMPLETE`.

  If you delete key material, you can use `ImportKey` to reimport the same key
  material into the Amazon Web Services Payment Cryptography key.

  You should delete a key only when you are sure that you don't need to use it
  anymore and no other parties are utilizing this key. If you aren't sure,
  consider deactivating it instead by calling `StopKeyUsage`.

  **Cross-account use:** This operation can't be used across different Amazon Web
  Services accounts.

  ## Related operations:

    * `RestoreKey`

    * `StartKeyUsage`

    * `StopKeyUsage`
  """
  def delete_key(%Client{} = client, input, options \\ []) do
    meta = metadata()

    Request.request_post(client, meta, "DeleteKey", input, options)
  end

  @doc """
  Exports a key from Amazon Web Services Payment Cryptography using either ANSI X9
  TR-34 or TR-31 key export standard.

  Amazon Web Services Payment Cryptography simplifies main or root key exchange
  process by eliminating the need of a paper-based key exchange process. It takes
  a modern and secure approach based of the ANSI X9 TR-34 key exchange standard.

  You can use `ExportKey` to export main or root keys such as KEK (Key Encryption
  Key), using asymmetric key exchange technique following ANSI X9 TR-34 standard.
  The ANSI X9 TR-34 standard uses asymmetric keys to establishes bi-directional
  trust between the two parties exchanging keys. After which you can export
  working keys using the ANSI X9 TR-31 symmetric key exchange standard as mandated
  by PCI PIN. Using this operation, you can share your Amazon Web Services Payment
  Cryptography generated keys with other service partners to perform cryptographic
  operations outside of Amazon Web Services Payment Cryptography

  ## TR-34 key export

  Amazon Web Services Payment Cryptography uses TR-34 asymmetric key exchange
  standard to export main keys such as KEK. In TR-34 terminology, the sending
  party of the key is called Key Distribution Host (KDH) and the receiving party
  of the key is called Key Receiving Host (KRH). In key export process, KDH is
  Amazon Web Services Payment Cryptography which initiates key export. KRH is the
  user receiving the key. Before you initiate TR-34 key export, you must obtain an
  export token by calling `GetParametersForExport`. This operation also returns
  the signing key certificate that KDH uses to sign the wrapped key to generate a
  TR-34 wrapped key block. The export token expires after 7 days.

  Set the following parameters:

  ## Definitions

  ### CertificateAuthorityPublicKeyIdentifier

  The `KeyARN` of the certificate chain that will sign the wrapping key
  certificate. This must exist within Amazon Web Services Payment Cryptography
  before you initiate TR-34 key export. If it does not exist, you can import it by
  calling `ImportKey` for `RootCertificatePublicKey`.

  ### ExportToken

  Obtained from KDH by calling `GetParametersForExport`.

  ### WrappingKeyCertificate

  Amazon Web Services Payment Cryptography uses this to wrap the key under export.

  When this operation is successful, Amazon Web Services Payment Cryptography
  returns the TR-34 wrapped key block.

  ## TR-31 key export

  Amazon Web Services Payment Cryptography uses TR-31 symmetric key exchange
  standard to export working keys. In TR-31, you must use a main key such as KEK
  to encrypt or wrap the key under export. To establish a KEK, you can use
  `CreateKey` or `ImportKey`. When this operation is successful, Amazon Web
  Services Payment Cryptography returns a TR-31 wrapped key block.

  **Cross-account use:** This operation can't be used across different Amazon Web
  Services accounts.

  ## Related operations:

    * `GetParametersForExport`

    * `ImportKey`
  """
  def export_key(%Client{} = client, input, options \\ []) do
    meta = metadata()

    Request.request_post(client, meta, "ExportKey", input, options)
  end

  @doc """
  Gets the Amazon Web Services Payment Cryptography key associated with the alias.

  **Cross-account use:** This operation can't be used across different Amazon Web
  Services accounts.

  ## Related operations:

    * `CreateAlias`

    * `DeleteAlias`

    * `ListAliases`

    * `UpdateAlias`
  """
  def get_alias(%Client{} = client, input, options \\ []) do
    meta = metadata()

    Request.request_post(client, meta, "GetAlias", input, options)
  end

  @doc """
  Gets the key material for an Amazon Web Services Payment Cryptography key,
  including the immutable and mutable data specified when the key was created.

  **Cross-account use:** This operation can't be used across different Amazon Web
  Services accounts.

  ## Related operations:

    * `CreateKey`

    * `DeleteKey`

    * `ListKeys`
  """
  def get_key(%Client{} = client, input, options \\ []) do
    meta = metadata()

    Request.request_post(client, meta, "GetKey", input, options)
  end

  @doc """
  Gets the export token and the signing key certificate to initiate a TR-34 key
  export from Amazon Web Services Payment Cryptography.

  The signing key certificate signs the wrapped key under export within the TR-34
  key payload. The export token and signing key certificate must be in place and
  operational before calling `ExportKey`. The export token expires in 7 days. You
  can use the same export token to export multiple keys from your service account.

  **Cross-account use:** This operation can't be used across different Amazon Web
  Services accounts.

  ## Related operations:

    * `ExportKey`

    * `GetParametersForImport`
  """
  def get_parameters_for_export(%Client{} = client, input, options \\ []) do
    meta = metadata()

    Request.request_post(client, meta, "GetParametersForExport", input, options)
  end

  @doc """
  Gets the import token and the wrapping key certificate to initiate a TR-34 key
  import into Amazon Web Services Payment Cryptography.

  The wrapping key certificate wraps the key under import within the TR-34 key
  payload. The import token and wrapping key certificate must be in place and
  operational before calling `ImportKey`. The import token expires in 7 days. The
  same import token can be used to import multiple keys into your service account.

  **Cross-account use:** This operation can't be used across different Amazon Web
  Services accounts.

  ## Related operations:

    * `GetParametersForExport`

    * `ImportKey`
  """
  def get_parameters_for_import(%Client{} = client, input, options \\ []) do
    meta = metadata()

    Request.request_post(client, meta, "GetParametersForImport", input, options)
  end

  @doc """
  Gets the public key certificate of the asymmetric key pair that exists within
  Amazon Web Services Payment Cryptography.

  Unlike the private key of an asymmetric key, which never leaves Amazon Web
  Services Payment Cryptography unencrypted, callers with
  `GetPublicKeyCertificate` permission can download the public key certificate of
  the asymmetric key. You can share the public key certificate to allow others to
  encrypt messages and verify signatures outside of Amazon Web Services Payment
  Cryptography

  **Cross-account use:** This operation can't be used across different Amazon Web
  Services accounts.
  """
  def get_public_key_certificate(%Client{} = client, input, options \\ []) do
    meta = metadata()

    Request.request_post(client, meta, "GetPublicKeyCertificate", input, options)
  end

  @doc """
  Imports keys and public key certificates into Amazon Web Services Payment
  Cryptography.

  Amazon Web Services Payment Cryptography simplifies main or root key exchange
  process by eliminating the need of a paper-based key exchange process. It takes
  a modern and secure approach based of the ANSI X9 TR-34 key exchange standard.

  You can use `ImportKey` to import main or root keys such as KEK (Key Encryption
  Key) using asymmetric key exchange technique following the ANSI X9 TR-34
  standard. The ANSI X9 TR-34 standard uses asymmetric keys to establishes
  bi-directional trust between the two parties exchanging keys.

  After you have imported a main or root key, you can import working keys to
  perform various cryptographic operations within Amazon Web Services Payment
  Cryptography using the ANSI X9 TR-31 symmetric key exchange standard as mandated
  by PCI PIN.

  You can also import a *root public key certificate*, a self-signed certificate
  used to sign other public key certificates, or a *trusted public key
  certificate* under an already established root public key certificate.

  ## To import a public root key certificate

  Using this operation, you can import the public component (in PEM cerificate
  format) of your private root key. You can use the imported public root key
  certificate for digital signatures, for example signing wrapping key or signing
  key in TR-34, within your Amazon Web Services Payment Cryptography account.

  Set the following parameters:

    * `KeyMaterial`: `RootCertificatePublicKey`

    * `KeyClass`: `PUBLIC_KEY`

    * `KeyModesOfUse`: `Verify`

    * `KeyUsage`: `TR31_S0_ASYMMETRIC_KEY_FOR_DIGITAL_SIGNATURE`

    * `PublicKeyCertificate`: The certificate authority used to sign the
  root public key certificate.

  ## To import a trusted public key certificate

  The root public key certificate must be in place and operational before you
  import a trusted public key certificate. Set the following parameters:

    * `KeyMaterial`: `TrustedCertificatePublicKey`

    * `CertificateAuthorityPublicKeyIdentifier`: `KeyArn` of the
  `RootCertificatePublicKey`.

    * `KeyModesOfUse` and `KeyUsage`: Corresponding to the cryptographic
  operations such as wrap, sign, or encrypt that you will allow the trusted public
  key certificate to perform.

    * `PublicKeyCertificate`: The certificate authority used to sign the
  trusted public key certificate.

  ## Import main keys

  Amazon Web Services Payment Cryptography uses TR-34 asymmetric key exchange
  standard to import main keys such as KEK. In TR-34 terminology, the sending
  party of the key is called Key Distribution Host (KDH) and the receiving party
  of the key is called Key Receiving Host (KRH). During the key import process,
  KDH is the user who initiates the key import and KRH is Amazon Web Services
  Payment Cryptography who receives the key. Before initiating TR-34 key import,
  you must obtain an import token by calling `GetParametersForImport`. This
  operation also returns the wrapping key certificate that KDH uses wrap key under
  import to generate a TR-34 wrapped key block. The import token expires after 7
  days.

  Set the following parameters:

    * `CertificateAuthorityPublicKeyIdentifier`: The `KeyArn` of the
  certificate chain that will sign the signing key certificate and should exist
  within Amazon Web Services Payment Cryptography before initiating TR-34 key
  import. If it does not exist, you can import it by calling by calling
  `ImportKey` for `RootCertificatePublicKey`.

    * `ImportToken`: Obtained from KRH by calling
  `GetParametersForImport`.

    * `WrappedKeyBlock`: The TR-34 wrapped key block from KDH. It
  contains the KDH key under import, wrapped with KRH provided wrapping key
  certificate and signed by the KDH private signing key. This TR-34 key block is
  generated by the KDH Hardware Security Module (HSM) outside of Amazon Web
  Services Payment Cryptography.

    * `SigningKeyCertificate`: The public component of the private key
  that signed the KDH TR-34 wrapped key block. In PEM certificate format.

  TR-34 is intended primarily to exchange 3DES keys. Your ability to export
  AES-128 and larger AES keys may be dependent on your source system.

  ## Import working keys

  Amazon Web Services Payment Cryptography uses TR-31 symmetric key exchange
  standard to import working keys. A KEK must be established within Amazon Web
  Services Payment Cryptography by using TR-34 key import. To initiate a TR-31 key
  import, set the following parameters:

    * `WrappedKeyBlock`: The key under import and encrypted using KEK.
  The TR-31 key block generated by your HSM outside of Amazon Web Services Payment
  Cryptography.

    * `WrappingKeyIdentifier`: The `KeyArn` of the KEK that Amazon Web
  Services Payment Cryptography uses to decrypt or unwrap the key under import.

  **Cross-account use:** This operation can't be used across different Amazon Web
  Services accounts.

  ## Related operations:

    * `ExportKey`

    * `GetParametersForImport`
  """
  def import_key(%Client{} = client, input, options \\ []) do
    meta = metadata()

    Request.request_post(client, meta, "ImportKey", input, options)
  end

  @doc """
  Lists the aliases for all keys in the caller's Amazon Web Services account and
  Amazon Web Services Region.

  You can filter the list of aliases. For more information, see [Using aliases](https://docs.aws.amazon.com/payment-cryptography/latest/userguide/keys-managealias.html)
  in the *Amazon Web Services Payment Cryptography User Guide*.

  This is a paginated operation, which means that each response might contain only
  a subset of all the aliases. When the response contains only a subset of
  aliases, it includes a `NextToken` value. Use this value in a subsequent
  `ListAliases` request to get more aliases. When you receive a response with no
  NextToken (or an empty or null value), that means there are no more aliases to
  get.

  **Cross-account use:** This operation can't be used across different Amazon Web
  Services accounts.

  ## Related operations:

    * `CreateAlias`

    * `DeleteAlias`

    * `GetAlias`

    * `UpdateAlias`
  """
  def list_aliases(%Client{} = client, input, options \\ []) do
    meta = metadata()

    Request.request_post(client, meta, "ListAliases", input, options)
  end

  @doc """
  Lists the keys in the caller's Amazon Web Services account and Amazon Web
  Services Region.

  You can filter the list of keys.

  This is a paginated operation, which means that each response might contain only
  a subset of all the keys. When the response contains only a subset of keys, it
  includes a `NextToken` value. Use this value in a subsequent `ListKeys` request
  to get more keys. When you receive a response with no NextToken (or an empty or
  null value), that means there are no more keys to get.

  **Cross-account use:** This operation can't be used across different Amazon Web
  Services accounts.

  ## Related operations:

    * `CreateKey`

    * `DeleteKey`

    * `GetKey`
  """
  def list_keys(%Client{} = client, input, options \\ []) do
    meta = metadata()

    Request.request_post(client, meta, "ListKeys", input, options)
  end

  @doc """
  Lists the tags for an Amazon Web Services resource.

  This is a paginated operation, which means that each response might contain only
  a subset of all the tags. When the response contains only a subset of tags, it
  includes a `NextToken` value. Use this value in a subsequent
  `ListTagsForResource` request to get more tags. When you receive a response with
  no NextToken (or an empty or null value), that means there are no more tags to
  get.

  **Cross-account use:** This operation can't be used across different Amazon Web
  Services accounts.

  ## Related operations:

    * `TagResource`

    * `UntagResource`
  """
  def list_tags_for_resource(%Client{} = client, input, options \\ []) do
    meta = metadata()

    Request.request_post(client, meta, "ListTagsForResource", input, options)
  end

  @doc """
  Cancels a scheduled key deletion during the waiting period.

  Use this operation to restore a `Key` that is scheduled for deletion.

  During the waiting period, the `KeyState` is `DELETE_PENDING` and
  `deletePendingTimestamp` contains the date and time after which the `Key` will
  be deleted. After `Key` is restored, the `KeyState` is `CREATE_COMPLETE`, and
  the value for `deletePendingTimestamp` is removed.

  **Cross-account use:** This operation can't be used across different Amazon Web
  Services accounts.

  ## Related operations:

    * `DeleteKey`

    * `StartKeyUsage`

    * `StopKeyUsage`
  """
  def restore_key(%Client{} = client, input, options \\ []) do
    meta = metadata()

    Request.request_post(client, meta, "RestoreKey", input, options)
  end

  @doc """
  Enables an Amazon Web Services Payment Cryptography key, which makes it active
  for cryptographic operations within Amazon Web Services Payment Cryptography

  **Cross-account use:** This operation can't be used across different Amazon Web
  Services accounts.

  ## Related operations:

    * `StopKeyUsage`
  """
  def start_key_usage(%Client{} = client, input, options \\ []) do
    meta = metadata()

    Request.request_post(client, meta, "StartKeyUsage", input, options)
  end

  @doc """
  Disables an Amazon Web Services Payment Cryptography key, which makes it
  inactive within Amazon Web Services Payment Cryptography.

  You can use this operation instead of `DeleteKey` to deactivate a key. You can
  enable the key in the future by calling `StartKeyUsage`.

  **Cross-account use:** This operation can't be used across different Amazon Web
  Services accounts.

  ## Related operations:

    * `DeleteKey`

    * `StartKeyUsage`
  """
  def stop_key_usage(%Client{} = client, input, options \\ []) do
    meta = metadata()

    Request.request_post(client, meta, "StopKeyUsage", input, options)
  end

  @doc """
  Adds or edits tags on an Amazon Web Services Payment Cryptography key.

  Tagging or untagging an Amazon Web Services Payment Cryptography key can allow
  or deny permission to the key.

  Each tag consists of a tag key and a tag value, both of which are case-sensitive
  strings. The tag value can be an empty (null) string. To add a tag, specify a
  new tag key and a tag value. To edit a tag, specify an existing tag key and a
  new tag value. You can also add tags to an Amazon Web Services Payment
  Cryptography key when you create it with `CreateKey`.

  **Cross-account use:** This operation can't be used across different Amazon Web
  Services accounts.

  ## Related operations:

    * `ListTagsForResource`

    * `UntagResource`
  """
  def tag_resource(%Client{} = client, input, options \\ []) do
    meta = metadata()

    Request.request_post(client, meta, "TagResource", input, options)
  end

  @doc """
  Deletes a tag from an Amazon Web Services Payment Cryptography key.

  Tagging or untagging an Amazon Web Services Payment Cryptography key can allow
  or deny permission to the key.

  **Cross-account use:** This operation can't be used across different Amazon Web
  Services accounts.

  ## Related operations:

    * `ListTagsForResource`

    * `TagResource`
  """
  def untag_resource(%Client{} = client, input, options \\ []) do
    meta = metadata()

    Request.request_post(client, meta, "UntagResource", input, options)
  end

  @doc """
  Associates an existing Amazon Web Services Payment Cryptography alias with a
  different key.

  Each alias is associated with only one Amazon Web Services Payment Cryptography
  key at a time, although a key can have multiple aliases. The alias and the
  Amazon Web Services Payment Cryptography key must be in the same Amazon Web
  Services account and Amazon Web Services Region

  **Cross-account use:** This operation can't be used across different Amazon Web
  Services accounts.

  ## Related operations:

    * `CreateAlias`

    * `DeleteAlias`

    * `GetAlias`

    * `ListAliases`
  """
  def update_alias(%Client{} = client, input, options \\ []) do
    meta = metadata()

    Request.request_post(client, meta, "UpdateAlias", input, options)
  end
end
